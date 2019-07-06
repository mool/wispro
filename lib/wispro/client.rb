module Wispro
  class Client
    include HTTParty
    base_uri 'https://www.cloud.wispro.co/api/v1'

    def initialize(token)
      @options = { headers: { 'Authorization' => token } }
    end

    def clients
      fetch_paginated_data('/clients')
    end

    def client(id)
      req = fetch_data("/clients/#{id}")
      return false unless req.parsed_response['status'] == 200

      req.parsed_response['data']
    end

    def contracts
      fetch_paginated_data('/contracts')
    end

    def contract(id)
      req = fetch_data("/contracts/#{id}")
      return false unless req.parsed_response['status'] == 200

      req.parsed_response['data']
    end

    def plans
      fetch_paginated_data('/plans')
    end

    def plan(id)
      req = fetch_data("/plans/#{id}")
      return false unless req.parsed_response['status'] == 200

      req.parsed_response['data']
    end

    def bmus
      fetch_paginated_data('/bmus')
    end

    def bmu(id)
      req = fetch_data("/bmus/#{id}")
      return false unless req.parsed_response['status'] == 200

      req.parsed_response['data']
    end

    def mikrotiks
      fetch_paginated_data('/mikrotiks')
    end

    def mikrotik(id)
      req = fetch_data("/mikrotiks/#{id}")
      return false unless req.parsed_response['status'] == 200

      req.parsed_response['data']
    end

    private

    def fetch_data(path, parameters = {})
      Wispro.logger.debug "GET - #{path} - #{parameters}"
      parameters.merge!(@options)
      self.class.get(path, parameters)
    end

    def fetch_paginated_data(path)
      page = 1
      results = []

      loop do
        req = fetch_data(path, query: { page: page }).parsed_response
        break unless req['status'] == 200

        results.concat(req['data'])

        break if page == req['meta']['pagination']['total_pages']

        page += 1
      end

      results
    end
  end
end
