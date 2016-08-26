class V1::ArticlesApi < Grape::API

  resources :articles do

    desc "show article", {

    }

    params do
      requires :id, type: String, desc: "article's _id"
    end

    get ":id" do
      begin
        article = Article.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound, BSON::InvalidObjectId
        article = {}
      end
      body data: article.to_json
    end


    desc "get articles list", {

    }

    params do

    end

    get do
      body data: Article.where(is_public: true).to_json
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
    end

    delete do

    end

  end
end