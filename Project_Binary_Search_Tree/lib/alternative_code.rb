def delete(value, node=@root)
  if node.nil?
    return
  end

  puts node.value
  test = delete(value, node.left_child)
  test = delete(value, node.right_child)

  p test

end
