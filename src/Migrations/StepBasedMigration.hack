/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST\Migrations;

use type Facebook\HHAST\EditableNode;

abstract class StepBasedMigration extends BaseMigration {
  abstract public function getSteps(): Traversable<IMigrationStep>;

  <<__Override>>
  final public function migrateFile(
    string $_path,
    EditableNode $ast,
  ): EditableNode {
    foreach ($this->getSteps() as $step) {
      $ast = $ast->rewrite(($node, $_) ==> $step->rewrite($node));
    }
    return $ast;
  }
}
