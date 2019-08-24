defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """

  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: tdata, left: nil} = tree, data) when data <= tdata do
    %{tree | left: new(data)}
  end

  def insert(%{data: tdata, left: tleft} = tree, data) when data <= tdata do
    %{tree | left: insert(tleft, data)}
  end

  def insert(%{data: tdata, right: nil} = tree, data) when data > tdata do
    %{tree | right: new(data)}
  end

  def insert(%{data: tdata, right: tright} = tree, data) when data > tdata do
    %{tree | right: insert(tright, data)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree), do: in_order(tree, [])

  def in_order(nil, acc), do: acc

  def in_order(%{left: nil, right: nil, data: data}, acc), do: acc ++ [data]

  def in_order(tree, acc) do
    acc = in_order(tree.left, acc)
    acc = acc ++ [tree.data]
    in_order(tree.right, acc)
  end
end
