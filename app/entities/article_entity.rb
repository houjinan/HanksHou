class ArticleEntity < Grape::Entity
  expose :id, documentation: {required: true, type: "String", desc: "article id"} do |instance, options|
    instance.id.to_s
  end
  expose :title, documentation: {required: true, type: "String", desc: "article 标题"}
  expose :content,    documentation: {required: true, type: "String", desc: "article 内容"}
  expose :created_at,    documentation: {required: true, type: "DateTime", desc: "article create time"} do |instance, options|
    instance.created_at.strftime("%F %R")
  end
end