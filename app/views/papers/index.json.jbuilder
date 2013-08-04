json.array!(@papers) do |paper|
  json.extract! paper, :title, :stats
  json.url paper_url(paper, format: :json)
end
