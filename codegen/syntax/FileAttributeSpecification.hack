/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<438666c85d0da5454d395214b98960da>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class FileAttributeSpecification extends EditableNode {

  private EditableNode $_left_double_angle;
  private EditableNode $_keyword;
  private EditableNode $_colon;
  private EditableNode $_attributes;
  private EditableNode $_right_double_angle;

  public function __construct(
    EditableNode $left_double_angle,
    EditableNode $keyword,
    EditableNode $colon,
    EditableNode $attributes,
    EditableNode $right_double_angle,
  ) {
    parent::__construct('file_attribute_specification');
    $this->_left_double_angle = $left_double_angle;
    $this->_keyword = $keyword;
    $this->_colon = $colon;
    $this->_attributes = $attributes;
    $this->_right_double_angle = $right_double_angle;
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $offset,
    string $source,
  ): this {
    $left_double_angle = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['file_attribute_specification_left_double_angle'],
      $file,
      $offset,
      $source,
    );
    $offset += $left_double_angle->getWidth();
    $keyword = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['file_attribute_specification_keyword'],
      $file,
      $offset,
      $source,
    );
    $offset += $keyword->getWidth();
    $colon = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['file_attribute_specification_colon'],
      $file,
      $offset,
      $source,
    );
    $offset += $colon->getWidth();
    $attributes = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['file_attribute_specification_attributes'],
      $file,
      $offset,
      $source,
    );
    $offset += $attributes->getWidth();
    $right_double_angle = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['file_attribute_specification_right_double_angle'],
      $file,
      $offset,
      $source,
    );
    $offset += $right_double_angle->getWidth();
    return new static(
      $left_double_angle,
      $keyword,
      $colon,
      $attributes,
      $right_double_angle,
    );
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'left_double_angle' => $this->_left_double_angle,
      'keyword' => $this->_keyword,
      'colon' => $this->_colon,
      'attributes' => $this->_attributes,
      'right_double_angle' => $this->_right_double_angle,
    ];
  }

  <<__Override>>
  public function rewriteDescendants(
    self::TRewriter $rewriter,
    ?vec<EditableNode> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);
    $parents[] = $this;
    $left_double_angle =
      $this->_left_double_angle->rewrite($rewriter, $parents);
    $keyword = $this->_keyword->rewrite($rewriter, $parents);
    $colon = $this->_colon->rewrite($rewriter, $parents);
    $attributes = $this->_attributes->rewrite($rewriter, $parents);
    $right_double_angle =
      $this->_right_double_angle->rewrite($rewriter, $parents);
    if (
      $left_double_angle === $this->_left_double_angle &&
      $keyword === $this->_keyword &&
      $colon === $this->_colon &&
      $attributes === $this->_attributes &&
      $right_double_angle === $this->_right_double_angle
    ) {
      return $this;
    }
    return new static(
      $left_double_angle,
      $keyword,
      $colon,
      $attributes,
      $right_double_angle,
    );
  }

  public function getLeftDoubleAngleUNTYPED(): EditableNode {
    return $this->_left_double_angle;
  }

  public function withLeftDoubleAngle(EditableNode $value): this {
    if ($value === $this->_left_double_angle) {
      return $this;
    }
    return new static(
      $value,
      $this->_keyword,
      $this->_colon,
      $this->_attributes,
      $this->_right_double_angle,
    );
  }

  public function hasLeftDoubleAngle(): bool {
    return !$this->_left_double_angle->isMissing();
  }

  /**
   * @return LessThanLessThanToken
   */
  public function getLeftDoubleAngle(): LessThanLessThanToken {
    return TypeAssert\instance_of(
      LessThanLessThanToken::class,
      $this->_left_double_angle,
    );
  }

  /**
   * @return LessThanLessThanToken
   */
  public function getLeftDoubleAnglex(): LessThanLessThanToken {
    return $this->getLeftDoubleAngle();
  }

  public function getKeywordUNTYPED(): EditableNode {
    return $this->_keyword;
  }

  public function withKeyword(EditableNode $value): this {
    if ($value === $this->_keyword) {
      return $this;
    }
    return new static(
      $this->_left_double_angle,
      $value,
      $this->_colon,
      $this->_attributes,
      $this->_right_double_angle,
    );
  }

  public function hasKeyword(): bool {
    return !$this->_keyword->isMissing();
  }

  /**
   * @return FileToken
   */
  public function getKeyword(): FileToken {
    return TypeAssert\instance_of(FileToken::class, $this->_keyword);
  }

  /**
   * @return FileToken
   */
  public function getKeywordx(): FileToken {
    return $this->getKeyword();
  }

  public function getColonUNTYPED(): EditableNode {
    return $this->_colon;
  }

  public function withColon(EditableNode $value): this {
    if ($value === $this->_colon) {
      return $this;
    }
    return new static(
      $this->_left_double_angle,
      $this->_keyword,
      $value,
      $this->_attributes,
      $this->_right_double_angle,
    );
  }

  public function hasColon(): bool {
    return !$this->_colon->isMissing();
  }

  /**
   * @return ColonToken
   */
  public function getColon(): ColonToken {
    return TypeAssert\instance_of(ColonToken::class, $this->_colon);
  }

  /**
   * @return ColonToken
   */
  public function getColonx(): ColonToken {
    return $this->getColon();
  }

  public function getAttributesUNTYPED(): EditableNode {
    return $this->_attributes;
  }

  public function withAttributes(EditableNode $value): this {
    if ($value === $this->_attributes) {
      return $this;
    }
    return new static(
      $this->_left_double_angle,
      $this->_keyword,
      $this->_colon,
      $value,
      $this->_right_double_angle,
    );
  }

  public function hasAttributes(): bool {
    return !$this->_attributes->isMissing();
  }

  /**
   * @return EditableList<ConstructorCall>
   */
  public function getAttributes(): EditableList<ConstructorCall> {
    return TypeAssert\instance_of(EditableList::class, $this->_attributes);
  }

  /**
   * @return EditableList<ConstructorCall>
   */
  public function getAttributesx(): EditableList<ConstructorCall> {
    return $this->getAttributes();
  }

  public function getRightDoubleAngleUNTYPED(): EditableNode {
    return $this->_right_double_angle;
  }

  public function withRightDoubleAngle(EditableNode $value): this {
    if ($value === $this->_right_double_angle) {
      return $this;
    }
    return new static(
      $this->_left_double_angle,
      $this->_keyword,
      $this->_colon,
      $this->_attributes,
      $value,
    );
  }

  public function hasRightDoubleAngle(): bool {
    return !$this->_right_double_angle->isMissing();
  }

  /**
   * @return GreaterThanGreaterThanToken
   */
  public function getRightDoubleAngle(): GreaterThanGreaterThanToken {
    return TypeAssert\instance_of(
      GreaterThanGreaterThanToken::class,
      $this->_right_double_angle,
    );
  }

  /**
   * @return GreaterThanGreaterThanToken
   */
  public function getRightDoubleAnglex(): GreaterThanGreaterThanToken {
    return $this->getRightDoubleAngle();
  }
}
