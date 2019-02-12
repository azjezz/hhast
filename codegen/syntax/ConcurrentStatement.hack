/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<07c8633289b25022785c9f8bb54a459f>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;

<<__ConsistentConstruct>>
final class ConcurrentStatement extends EditableNode {

  private EditableNode $_keyword;
  private EditableNode $_statement;

  public function __construct(EditableNode $keyword, EditableNode $statement) {
    parent::__construct('concurrent_statement');
    $this->_keyword = $keyword;
    $this->_statement = $statement;
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $offset,
    string $source,
  ): this {
    $keyword = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['concurrent_keyword'],
      $file,
      $offset,
      $source,
    );
    $offset += $keyword->getWidth();
    $statement = EditableNode::fromJSON(
      /* UNSAFE_EXPR */ $json['concurrent_statement'],
      $file,
      $offset,
      $source,
    );
    $offset += $statement->getWidth();
    return new static($keyword, $statement);
  }

  <<__Override>>
  public function getChildren(): dict<string, EditableNode> {
    return dict[
      'keyword' => $this->_keyword,
      'statement' => $this->_statement,
    ];
  }

  <<__Override>>
  public function rewriteDescendants(
    self::TRewriter $rewriter,
    ?vec<EditableNode> $parents = null,
  ): this {
    $parents = $parents === null ? vec[] : vec($parents);
    $parents[] = $this;
    $keyword = $this->_keyword->rewrite($rewriter, $parents);
    $statement = $this->_statement->rewrite($rewriter, $parents);
    if ($keyword === $this->_keyword && $statement === $this->_statement) {
      return $this;
    }
    return new static($keyword, $statement);
  }

  public function getKeywordUNTYPED(): EditableNode {
    return $this->_keyword;
  }

  public function withKeyword(EditableNode $value): this {
    if ($value === $this->_keyword) {
      return $this;
    }
    return new static($value, $this->_statement);
  }

  public function hasKeyword(): bool {
    return !$this->_keyword->isMissing();
  }

  /**
   * @return ConcurrentToken
   */
  public function getKeyword(): ConcurrentToken {
    return TypeAssert\instance_of(ConcurrentToken::class, $this->_keyword);
  }

  /**
   * @return ConcurrentToken
   */
  public function getKeywordx(): ConcurrentToken {
    return $this->getKeyword();
  }

  public function getStatementUNTYPED(): EditableNode {
    return $this->_statement;
  }

  public function withStatement(EditableNode $value): this {
    if ($value === $this->_statement) {
      return $this;
    }
    return new static($this->_keyword, $value);
  }

  public function hasStatement(): bool {
    return !$this->_statement->isMissing();
  }

  /**
   * @return CompoundStatement
   */
  public function getStatement(): CompoundStatement {
    return TypeAssert\instance_of(CompoundStatement::class, $this->_statement);
  }

  /**
   * @return CompoundStatement
   */
  public function getStatementx(): CompoundStatement {
    return $this->getStatement();
  }
}
