
describe Article do
  it "create article" do
    article = build :article
    result = article.save
    expect(result).to eq(true)
  end

  it "update article" do
    article = create :article
    article.update(title: "updateStr")
    expect(article.title).to eq("updateStr")
  end

  it "delete article" do
    article = create :article
    result = article.destroy
    expect(result).to eq(true)
  end
end