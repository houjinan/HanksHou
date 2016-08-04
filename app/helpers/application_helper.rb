module ApplicationHelper
  EMPTY_STRING = ''.freeze
  # 可按需修改
  LANGUAGES_LISTS = { 'Ruby' => 'ruby', 'HTML / ERB' => 'erb', 'CSS / SCSS' => 'scss', 'JavaScript' => 'js',
                      'YAML <i>(.yml)</i>' => 'yml', 'CoffeeScript' => 'coffee', 'Nginx / Redis <i>(.conf)</i>' => 'conf',
                      'Python' => 'python', 'PHP' => 'php', 'Java' => 'java', 'Erlang' => 'erlang', 'Shell / Bash' => 'shell' }
  def insert_code_menu_items_tag
    lang_list = []
    LANGUAGES_LISTS.each do |k, l|
      lang_list << content_tag(:li) do
        link_to raw(k), '#', data: { lang: l }
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
end
