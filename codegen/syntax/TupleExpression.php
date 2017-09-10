<?hh
/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<99f690f131a6e0992be1e06019060cdb>>
 */
namespace Facebook\HHAST;
use type Facebook\TypeAssert\TypeAssert;

final class TupleExpression extends EditableSyntax {

  private EditableSyntax $_keyword;
  private EditableSyntax $_left_paren;
  private EditableSyntax $_items;
  private EditableSyntax $_right_paren;

  public function __construct(
    EditableSyntax $keyword,
    EditableSyntax $left_paren,
    EditableSyntax $items,
    EditableSyntax $right_paren,
  ) {
    parent::__construct('tuple_expression');
    $this->_keyword = $keyword;
    $this->_left_paren = $left_paren;
    $this->_items = $items;
    $this->_right_paren = $right_paren;
  }

  public static function from_json(
    array<string, mixed> $json,
    int $position,
    string $source,
  ): this {
    $keyword = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['tuple_expression_keyword'],
      $position,
      $source,
    );
    $position += $keyword->width();
    $left_paren = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['tuple_expression_left_paren'],
      $position,
      $source,
    );
    $position += $left_paren->width();
    $items = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['tuple_expression_items'],
      $position,
      $source,
    );
    $position += $items->width();
    $right_paren = EditableSyntax::from_json(
      /* UNSAFE_EXPR */ $json['tuple_expression_right_paren'],
      $position,
      $source,
    );
    $position += $right_paren->width();
    return new self($keyword, $left_paren, $items, $right_paren);
  }

  public function children(): KeyedTraversable<string, EditableSyntax> {
    yield 'keyword' => $this->_keyword;
    yield 'left_paren' => $this->_left_paren;
    yield 'items' => $this->_items;
    yield 'right_paren' => $this->_right_paren;
  }

  public function rewrite(
    self::TRewriter $rewriter,
    ?Traversable<EditableSyntax> $parents = null,
  ): EditableSyntax {
    $parents = $parents === null ? vec[] : vec($parents);
    $child_parents = $parents;
    $child_parents[] = $this;
    $keyword = $this->_keyword->rewrite($rewriter, $child_parents);
    $left_paren = $this->_left_paren->rewrite($rewriter, $child_parents);
    $items = $this->_items->rewrite($rewriter, $child_parents);
    $right_paren = $this->_right_paren->rewrite($rewriter, $child_parents);
    if (
      $keyword === $this->_keyword &&
      $left_paren === $this->_left_paren &&
      $items === $this->_items &&
      $right_paren === $this->_right_paren
    ) {
      $node = $this;
    } else {
      $node = new self($keyword, $left_paren, $items, $right_paren);
    }
    return $rewriter($node, $parents);
  }

  public function keyword(): TupleToken {
    return $this->keywordx();
  }

  public function keywordx(): TupleToken {
    return TypeAssert::isInstanceOf(TupleToken::class, $this->_keyword);
  }

  public function raw_keyword(): EditableSyntax {
    return $this->_keyword;
  }

  public function with_keyword(EditableSyntax $value): this {
    return
      new self($value, $this->_left_paren, $this->_items, $this->_right_paren);
  }

  public function left_paren(): LeftParenToken {
    return $this->left_parenx();
  }

  public function left_parenx(): LeftParenToken {
    return TypeAssert::isInstanceOf(LeftParenToken::class, $this->_left_paren);
  }

  public function raw_left_paren(): EditableSyntax {
    return $this->_left_paren;
  }

  public function with_left_paren(EditableSyntax $value): this {
    return
      new self($this->_keyword, $value, $this->_items, $this->_right_paren);
  }

  public function items(): EditableList {
    return $this->itemsx();
  }

  public function itemsx(): EditableList {
    return TypeAssert::isInstanceOf(EditableList::class, $this->_items);
  }

  public function raw_items(): EditableSyntax {
    return $this->_items;
  }

  public function with_items(EditableSyntax $value): this {
    return new self(
      $this->_keyword,
      $this->_left_paren,
      $value,
      $this->_right_paren,
    );
  }

  public function right_paren(): RightParenToken {
    return $this->right_parenx();
  }

  public function right_parenx(): RightParenToken {
    return
      TypeAssert::isInstanceOf(RightParenToken::class, $this->_right_paren);
  }

  public function raw_right_paren(): EditableSyntax {
    return $this->_right_paren;
  }

  public function with_right_paren(EditableSyntax $value): this {
    return new self($this->_keyword, $this->_left_paren, $this->_items, $value);
  }
}