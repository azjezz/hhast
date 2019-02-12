/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */


namespace Facebook\HHAST\TestLib;

use namespace Facebook\DiffLib;
use namespace HH\Lib\Str;

final class ExpectObj<T> extends \Facebook\FBExpect\ExpectObj<T> {
  public function __construct(private T $var) {
    parent::__construct($var);
  }

  public function toMatchExpectFile(
    string $expect_file,
  ): void where T = string {
    $this->toMatchExpectFileWithInputFile(
      $expect_file,
      Str\strip_suffix($expect_file, '.expect').'.in',
    );
  }

  public function toMatchExpectFileWithInputFile(
    string $expect_file,
    string $input_file,
  ): void where T = string {
    if (!Str\starts_with($expect_file, '/')) {
      $expect_file = __DIR__.'/../fixtures/'.$expect_file;
      $input_file = __DIR__.'/../fixtures/'.$input_file;
    }
    $out_file = Str\strip_suffix($expect_file, '.expect').'.out';
    $code = $this->var;

    \file_put_contents(Str\strip_suffix($expect_file, '.expect').'.out', $code);
    if (!\file_exists($expect_file)) {
      \stream_set_blocking(\STDERR, true);
      \fprintf(\STDERR, "\n===== NEW TEST: %s =====\n", $expect_file);
      \fprintf(\STDERR, "----- %s -----\n", $input_file);
      \fwrite(\STDERR, \file_get_contents($input_file));
      \fprintf(\STDERR, "----- %s -----\n", $out_file);
      \fwrite(\STDERR, $code);

      $diff = DiffLib\StringDiff::lines(\file_get_contents($input_file), $code)
        ->getUnifiedDiff();
      if (Str\length($diff) < Str\length($code)) {
        if (\posix_isatty(\STDERR)) {
          $diff = DiffLib\CLIColoredUnifiedDiff::create(
            \file_get_contents($input_file),
            $code,
          );
        }
        \fprintf(
          \STDERR,
          "----- diff -u %s %s ----\n",
          \basename($input_file),
          \basename($out_file),
        );
        \fwrite(\STDERR, $diff);
      }
      \fwrite(\STDERR, "----- END -----\n");
      \stream_set_blocking(\STDERR, false);

      $recorded = false;
      if (\posix_isatty(\STDIN) && \posix_isatty(\STDERR)) {
        \fprintf(\STDERR, "Would you like to save this output? [y/N] ");
        \stream_set_blocking(\STDIN, true);
        $response = Str\trim(\fgets(\STDIN));
        \stream_set_blocking(\STDIN, false);
        if ($response === 'y') {
          \file_put_contents($expect_file, $code);
          $recorded = true;
        }
      } else {
        throw new \Exception($expect_file.' does not exist');
      }
    }
    $this->toBeSame(\file_get_contents($expect_file));
  }
}
