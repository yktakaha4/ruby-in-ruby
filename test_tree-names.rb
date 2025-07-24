# frozen_string_literal: true

require 'minitest/autorun'
require 'open3'

class TestTreeNames < Minitest::Test
  def setup
    @script_path = File.join(File.dirname(__FILE__), 'tree-names.rb')
  end

  def test_preorder_traversal_output
    stdout, stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'
    assert_empty stderr, 'No errors should be output to stderr'

    lines = stdout.strip.split("\n")

    # 先行順序巡回の期待される出力
    expected_output = [
      '"節1"',
      '"節2"',
      '"葉A"',
      '"葉B"',
      '"節3"',
      '"葉C"',
      '"葉D"'
    ]

    assert_equal expected_output, lines, 'Preorder traversal should output nodes in correct order'
  end

  def test_output_line_count
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'

    lines = stdout.strip.split("\n")
    assert_equal 7, lines.length, 'Should output exactly 7 lines (all nodes)'
  end

  def test_root_node_first
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'

    lines = stdout.strip.split("\n")
    refute_empty lines, 'Should have output'
    assert_equal '"節1"', lines.first, 'Root node should be output first'
  end

  def test_leaf_nodes_in_output
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'

    lines = stdout.strip.split("\n")

    # 葉ノードがすべて含まれていることを確認
    assert_includes lines, '"葉A"', 'Should contain leaf node A'
    assert_includes lines, '"葉B"', 'Should contain leaf node B'
    assert_includes lines, '"葉C"', 'Should contain leaf node C'
    assert_includes lines, '"葉D"', 'Should contain leaf node D'
  end

  def test_internal_nodes_in_output
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'

    lines = stdout.strip.split("\n")

    # 内部ノード（節）がすべて含まれていることを確認
    assert_includes lines, '"節1"', 'Should contain internal node 1'
    assert_includes lines, '"節2"', 'Should contain internal node 2'
    assert_includes lines, '"節3"', 'Should contain internal node 3'
  end

  def test_preorder_sequence
    stdout, _stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute successfully'

    lines = stdout.strip.split("\n")

    # 先行順序の特性をテスト：親ノードが子ノードより先に出現
    node1_index = lines.index('"節1"')
    node2_index = lines.index('"節2"')
    node3_index = lines.index('"節3"')
    leaf_a_index = lines.index('"葉A"')
    leaf_b_index = lines.index('"葉B"')
    leaf_c_index = lines.index('"葉C"')
    leaf_d_index = lines.index('"葉D"')

    # 節1は最初に出現
    assert_equal 0, node1_index, '節1 should be first'

    # 節2は葉A、葉Bより前に出現
    assert node2_index < leaf_a_index, '節2 should appear before 葉A'
    assert node2_index < leaf_b_index, '節2 should appear before 葉B'

    # 節3は葉C、葉Dより前に出現
    assert node3_index < leaf_c_index, '節3 should appear before 葉C'
    assert node3_index < leaf_d_index, '節3 should appear before 葉D'

    # 左の子木が右の子木より先に処理される
    assert node2_index < node3_index, 'Left subtree (節2) should be processed before right subtree (節3)'
    assert leaf_a_index < leaf_b_index, '葉A should appear before 葉B'
    assert leaf_c_index < leaf_d_index, '葉C should appear before 葉D'
  end

  def test_no_runtime_errors
    stdout, stderr, status = Open3.capture3("ruby #{@script_path}")

    assert status.success?, 'Script should execute without errors'
    assert_empty stderr, 'Should not output any error messages'
    refute_empty stdout, 'Should produce output'
  end
end
