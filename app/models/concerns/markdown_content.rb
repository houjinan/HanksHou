module MarkdownContent
  extend ActiveSupport::Concern
  include ActionView::Helpers::SanitizeHelper
  include ApplicationHelper

  included do
    before_save :markdown_content
  end

  private

  def markdown_content
    if self.content_changed?
      self.content_html = sanitize_markdown(MarkdownTopicConverter.format(content))
    end
  end
end
