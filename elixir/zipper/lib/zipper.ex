defmodule Zipper do
  defstruct node: nil, trail: []
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{node: bin_tree, trail: []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{node: node, trail: []}), do: node
  def to_tree(z), do: z |> up |> to_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{node: %BinTree{left: nil}}), do: nil
  def left(z) do
    %Zipper{
      node: z.node.left, 
      trail: [{:left, z.node.value, z.node.right} | z.trail]
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{node: %BinTree{right: nil}}), do: nil
  def right(z) do
    %Zipper{
      node: z.node.right, 
      trail: [{:right, z.node.value, z.node.left} | z.trail]
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{trail: []}), do: nil
  def up(%Zipper{node: node, trail: [{:right, value, branch} | trail]}) do
    %Zipper{
      node: %BinTree{
        value: value,
        left: branch,
        right: node
      },
      trail: trail
    }
  end
  def up(%Zipper{node: node, trail: [{:left, value, branch} | trail]}) do
    %Zipper{
      node: %BinTree{
        value: value,
        left: node,
        right: branch
      },
      trail: trail
    }
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
     %{zipper | node: %{zipper.node | value: value}}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    %{zipper | node: %{zipper.node | left: left}}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    %{zipper | node: %{zipper.node | right: right}}
  end
end
