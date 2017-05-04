class V1::ArticlesApi < Grape::API

  before do
    token_authenticate!
  end

  params do
    requires :auth_token, type: String
  end

  resources :articles do

    desc "show article", {
      entity: ArticleEntity
    }

    params do
      requires :id, type: String, desc: "article's _id", allow_blank: false
    end


    get ":id" do
      begin
        article = api_user.articles.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound, BSON::InvalidObjectId
        error! "not search article", 400
      end

     present article, with: ArticleEntity
     body body()
    end


    desc "get articles list", {
      entity: ArticleEntity
    }

    params do

    end

    get do
      articles = api_user.articles
      present articles, with: ArticleEntity
      body total_page: articles.count, total: articles.count, per_page: 20, page: 1, data: body()
    end



    desc "create article", {

    }

    params do
      requires :title, type: String, desc: "article's title", allow_blank: false
      optional :content, type: String, desc: "article's content", allow_blank: true
    end

    post do
      article = Article.create(title: params["title"], content: params["content"], user: @api_user)
      present article, with: ArticleEntity
      body data: body()
    end


    desc "update article", {

    }

    params do
      requires :id, type: String, desc: "article's _id"
      requires :title, type: String, desc: "article's title", allow_blank: false
      requires :content, type: String, desc: "article's content", allow_blank: true
    end

    put ":id" do
      article_params = {}
      article_params["title"] = params["title"] if params["title"].present?
      article_params["content"] = params["content"] if params["content"].present?
      begin
        article = api_user.articles.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound, BSON::InvalidObjectId
        error! "not search article", 400
      end

      if article.present? && article_params.present?
        article.update(article_params)
      end
      body code: 0
    end


    desc "delete article", {

    }

    params do
      requires :id, type: String, desc: "article's _id"
    end

    delete ":id" do
      begin
        article = api_user.articles.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound, BSON::InvalidObjectId
        error! "not search article", 400
      end

      article.destroy()
      body code: 0
    end

    

  end
end