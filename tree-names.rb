# frozen_string_literal: true

def preorder(tree)
  p(tree[0])
  return unless tree[0].start_with?('節')

  preorder(tree[1])
  preorder(tree[2])
end

node1 = ['節1', ['節2', ['葉A'], ['葉B']], ['節3', ['葉C'], ['葉D']]]
preorder(node1)
