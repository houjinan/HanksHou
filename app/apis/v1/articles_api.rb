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
     body data: body()
    end


    desc "get articles list", {
      entity: ArticleEntity
    }

    params do

    end

    get do
      articles = api_user.articles
      present articles, with: ArticleEntity
      body data: body()
    end



    desc "create article", {

    }

    params do
    end

    post do

    end


    desc "update article", {

    }

    params do
    end

    patch do

    end


    desc "delete article", {

    }

    params do
      requires :id, type: String, desc: "article's _id"
    end

    delete ":id" do

    end

  end
end