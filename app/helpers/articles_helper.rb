module ArticlesHelper

  def load_board_title
    if cookies[:nav_active].blank? || cookies[:nav_active] == "technique"
      "人生最大的快乐不在于占有什么，而在于追求什么的过程"
    elsif cookies[:nav_active] == "experience"
      "博观而约取,厚积而薄发"
    elsif cookies[:nav_active] == "travel"
      "乘兴而行，兴尽而返"
    elsif cookies[:nav_active] == "reading"
      "读书何所求? 将以通事理"
    elsif cookies[:nav_active] == "about"
      "about"
    else
      ""
    end
  end


  def load_board_description
    if cookies[:nav_active].blank? || cookies[:nav_active] == "technique"
      "探索 尝试 总结"
    elsif cookies[:nav_active] == "experience"
      "思考 回顾 发现 总结"
    elsif cookies[:nav_active] == "travel"
      "旅行"
    elsif cookies[:nav_active] == "reading"
      "充实 学习"
    elsif cookies[:nav_active] == "about"
      "about"
    else
      ""
    end
  end
end
