module Wispro
  class Client
    include HTTParty
    base_uri 'https://www.cloud.wispro.co/api/v1'

    PAGINATED_MODELS = {
      bmus:      :bmu,
      clients:   :client,
      contracts: :contract,
      coverages: :coverage,
      mikrotiks: :mikrotik,
      nodes:     :node,
      plans:     :plan
    }.freeze

    def initialize(token)
      @options = { headers: { 'Authorization' => token } }
    end

    PAGINATED_MODELS.each do |plural, singular|
      define_method plural do |&block|
        fetch_paginated_data("/#{plural}") { |rows| block&.call(rows) }
      end

      define_method singular do |id|
        req = fetch_data("/#{plural}/#{id}")
        return false unless req['status'] == 200

        req['data']
      end
    end

    def update_client(id, data)
      req = update_data("/clients/#{id}", body: data)
      return false unless req['status'] == 200

      req['data']
    end

    def update_contract(id, data)
      req = update_data("/contracts/#{id}", body: data)
      return false unless req['status'] == 200

      req['data']
    end

    def update_plan(id, data)
      req = update_data("/plans/#{id}", body: data)
      return false unless req['status'] == 200

      req['data']
    end

    private

    def fetch_data(path, parameters = {})
      Wispro.logger.debug "GET - #{path} - #{parameters}"
      parameters.merge!(@options)
      self.class.get(path, parameters).parsed_response
    end

    def fetch_paginated_data(path)
      page = 1
      results = []

      loop do
        req = fetch_data(path, query: { page: page })
        break unless req['status'] == 200

        yield req['data'] if block_given?

        results.concat(req['data'])

        break if page == req['meta']['pagination']['total_pages']

        page += 1
      end

      results
    end

    def update_data(path, parameters = {})
      Wispro.logger.debug "PUT - #{path} - #{parameters}"
      parameters.merge!(@options)
      self.class.put(path, parameters).parsed_response
    end
  end
end
