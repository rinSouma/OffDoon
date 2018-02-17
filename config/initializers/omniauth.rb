Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mastodon, scope: 'read write', credentials: lambda { |domain, callback_url|
    Rails.logger.info "Requested credentials for #{domain} with callback URL #{callback_url}"

    existing = MastodonClient.find_by(domain: domain)
    return [existing.client_id, existing.client_secret] unless existing.nil?

    client = Mastodon::REST::Client.new(base_url: "https://#{domain}")
    app = client.create_app('OffDoon', callback_url, 'read write')

    MastodonClient.create!(domain: domain, client_id: app.client_id, client_secret: app.client_secret)

    [app.client_id, app.client_secret]
  }
end