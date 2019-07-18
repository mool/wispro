require 'webmock/rspec'
require 'wispro'

WebMock.disable_net_connect!(allow_localhost: true)
Wispro.logger.level = Logger::INFO

describe Wispro::Client do
  before :each do
    @client = Wispro::Client.new('super-secret-token')
    @base_url = 'https://www.cloud.wispro.co/api/v1'
  end

  it 'get a client' do
    client_id = 'e3431c99-bfe3-547b-82b1-308f899e13a2'

    stub_request(:get, @base_url + '/clients/' + client_id)
      .to_return(File.new('spec/fixtures/client.txt'))

    expect(@client.client(client_id)['id']).to eql(client_id)
  end

  it 'get all the clients' do
    stub_request(:get, @base_url + '/clients?page=1')
      .to_return(File.new('spec/fixtures/clients_1.txt'))
    stub_request(:get, @base_url + '/clients?page=2')
      .to_return(File.new('spec/fixtures/clients_2.txt'))

    expect(@client.clients.count).to eql(40)
  end

  it 'get a plan' do
    plan_id = '0a941d3d-c6ef-4056-8663-65b8a0a14636'

    stub_request(:get, @base_url + '/plans/' + plan_id)
      .to_return(File.new('spec/fixtures/plan.txt'))

    expect(@client.plan(plan_id)['id']).to eql(plan_id)
  end

  it 'get all the plans' do
    stub_request(:get, @base_url + '/plans?page=1')
      .to_return(File.new('spec/fixtures/plans_1.txt'))

    expect(@client.plans.count).to eql(20)
  end

  it 'get a contract' do
    contract_id = 'adccdca2-6f60-41d2-b853-c44ac80c5cbf'

    stub_request(:get, @base_url + '/contracts/' + contract_id)
      .to_return(File.new('spec/fixtures/contract.txt'))

    expect(@client.contract(contract_id)['id']).to eql(contract_id)
  end

  it 'get all the contracts' do
    stub_request(:get, @base_url + '/contracts?page=1')
      .to_return(File.new('spec/fixtures/contracts_1.txt'))

    expect(@client.contracts.count).to eql(20)
  end
end
