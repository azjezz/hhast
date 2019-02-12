/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST;

use namespace HH\Lib\{C, Dict, Vec};

final class EditableList<Titem as ?EditableNode> extends EditableNode {
  private vec<EditableNode> $_children;
  /**
   * Use `EditableList::createMaybeEmptyList()` or
   * `EditableList::createNonEmptyListOrMissing()` instead to be explicit
   * about desired behavior.
   */
  <<__Override>>
  public function __construct(vec<EditableNode> $children) {
    parent::__construct('list');
    $this->_children = vec($children);
  }

  <<__Override>>
  final public function isList(): bool {
    return true;
  }

  <<__Override>>
  public function toVec(): vec<EditableNode> {
    return $this->_children;
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return Dict\pull_with_key(
      $this->_children,
      ($_, $v) ==> $v,
      ($k, $_) ==> (string) $k,
    );
  }

  final public function getItems(): vec<Titem> {
    // The `filter_nulls()` is needed for for expressions like
    // `list($a,,$c) = $foo` and types like `\Foo\Bar`, now that the first
    // is parsed as name token items with  backslash separators - i.e. the first
    // item is empty.

    /* HH_FIXME[4110] we have to trust the typechecker here; in future, use
     * reified generics */
    return Vec\map(
      $this->_children,
      $child ==> $child instanceof ListItem ? $child->getItem() : $child,
    );// |> Vec\filter_nulls($$);
  }

  final public function getItemsOfType<T as EditableNode>(
    classname<T> $what,
  ): vec<T> {
    $out = vec[];
    foreach ($this->getItems() as $item) {
      if ($item instanceof $what) {
        $out[] = $item;
      }
    }
    return $out;
  }

  <<__Deprecated("Use createNonEmptyListOrMissing() instead")>>
  public static function fromItems(
    vec<EditableNode> $items,
  ): EditableNode {
    return self::createNonEmptyListOrMissing($items);
  }

  public static function createNonEmptyListOrMissing(
    vec<EditableNode> $items,
  ): EditableNode {
    if (C\count($items) === 0) {
      return Missing();
    } else {
      return new self($items);
    }
  }

  public static function createMaybeEmptyList<T as EditableNode>(
    vec<T> $items,
  ): EditableList<T> {
    return new self($items);
  }

  public static function concat(
    EditableNode $left,
    EditableNode $right,
  ): EditableNode {
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
    string $file,
    int $offset,
    string $source,
  ): this {
    $children = vec[];
    $current_position = $offset;
    foreach (/* UNSAFE_EXPR */$json['elements'] as $element) {
      $child =
        EditableNode::fromJSON($element, $file, $current_position, $source);
      $children[] = $child;
      $current_position += $child->getWidth();
    }
    return new EditableList($children);
  }

  <<__Override>>
  public function rewriteDescendants(
    self::TRewriter $rewriter,
    ?vec<EditableNode> $parents = null,
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
    ?vec<EditableNode> $parents = null,
  ): EditableNode {
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
