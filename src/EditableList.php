<?hh // strict
/**
 * Copyright (c) 2016, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional
 * grant of patent rights can be found in the PATENTS file in the same
 * directory.
 *
 */

namespace Facebook\HHAST;

use namespace HH\Lib\{C, Vec};

final class EditableList extends EditableSyntax {
  private vec<EditableSyntax> $_children;
  <<__Override>>
  public function __construct(Traversable<EditableSyntax> $children) {
    parent::__construct('list');
    $this->_children = vec($children);
  }

  <<__Override>>
  final public function isList(): bool {
    return true;
  }

  <<__Override>>
  public function toVec(): vec<EditableSyntax> {
    return $this->_children;
  }

  <<__Override>>
  public function getChildren(): KeyedTraversable<string, EditableSyntax> {
    $i = 0;
    foreach ($this->_children as $child) {
      yield (string) $i => $child;
      $i++;
    }
  }

  final public function getItemsOfType<T as EditableSyntax>(
    classname<T> $what,
  ): Traversable<EditableSyntax> {
    foreach ($this->_children as $child) {
      if ($child instanceof ListItem) {
        $child = $child->getItem();
      }
      if ($child instanceof $what) {
        yield $child;
      }
    }
  }

  public static function fromItems(
    Traversable<EditableSyntax> $syntax_list,
  ): EditableSyntax {
    $syntax_list = vec($syntax_list);
    if (C\count($syntax_list) === 0) {
      return Missing();
    } else {
      return new EditableList($syntax_list);
    }
  }

  public static function concatenate_lists(
    EditableSyntax $left,
    EditableSyntax $right,
  ): EditableSyntax {
    if ($left->isMissing()) {
      return $right;
    }
    if ($right->isMissing()) {
      return $left;
    }
    return new EditableList(Vec\concat($left->toVec(), $right->toVec()));
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $children = vec[];
    $current_position = $position;
    foreach (/* UNSAFE_EXPR */$json['elements'] as $element) {
      $child = EditableSyntax::fromJSON($element, $current_position, $source);
      $children[] = $child;
      $current_position += $child->getWidth();
    }
    return new EditableList($children);
  }

  <<__Override>>
  public function rewriteDescendants(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);

    $dirty = false;
    $new_children = vec[];
    $new_parents = $parents;
    $new_parents[] = $this;
    foreach ($this->getChildren() as $child) {
      $new_child = $child->rewrite($rewriter, $new_parents);
      if ($new_child !== $child) {
        $dirty = true;
      }
      if ($new_child !== null && !$new_child->isMissing()) {
        if ($new_child->isList()) {
          foreach ($new_child->getChildren() as $n) {
            $new_children[] = $n;
          }
        } else {
          $new_children[] = $new_child;
        }
      }
    }

    if (!$dirty) {
      return $this;
    }

    return new self($new_children);
  }

  <<__Override>>
  public function rewrite(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): EditableSyntax {
    $parents = $parents === null ? vec[] : vec($parents);
    $with_rewritten_children = $this->rewriteDescendants(
      $rewriter,
      $parents,
    );
    if (C\is_empty($with_rewritten_children->_children)) {
      $node = Missing();
    } else {
      $node = $with_rewritten_children;
    }
    return $rewriter($node, $parents);
  }
}
