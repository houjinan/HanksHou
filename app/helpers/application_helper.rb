module ApplicationHelper
  EMPTY_STRING = ''.freeze
  ALLOW_TAGS = %w(p br img h1 h2 h3 h4 h5 h6 blockquote pre code b i
                  strong em table tr td tbody th strike del u a ul ol li span hr)
  ALLOW_ATTRIBUTES = %w(href src class width height id title alt target rel data-floor)
  # 可按需修改
  LANGUAGES_LISTS = { 'Ruby' => 'ruby', 'HTML / ERB' => 'erb', 'CSS / SCSS' => 'scss', 'JavaScript' => 'js',
                      'YAML <i>(.yml)</i>' => 'yml', 'CoffeeScript' => 'coffee', 'Nginx / Redis <i>(.conf)</i>' => 'conf',
                      'Python' => 'python', 'PHP' => 'php', 'Java' => 'java', 'Erlang' => 'erlang', 'Shell / Bash' => 'shell' }
  def insert_code_menu_items_tag
    lang_list = []
    LANGUAGES_LISTS.each do |k, l|
      lang_list << content_tag(:li) do
        link_to raw(k), "javascript: appendCodesFromHint(\"#{l}\")", data: { lang: l }
      end
    end
    raw lang_list.join(EMPTY_STRING)
  end

  def icon_tag(name, opts = {})
    label = EMPTY_STRING
    if opts[:label]
      label = %(<span>#{opts[:label]}</span>)
    end
    raw "<i class='fa fa-#{name}'></i> #{label}"
  end



  def sanitize_markdown(body)
    # TODO: This method slow, 3.5ms per call in topic body
    sanitize(body, tags: ALLOW_TAGS, attributes: ALLOW_ATTRIBUTES)
  end
end
