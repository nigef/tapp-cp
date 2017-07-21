class ContractsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    contracts = []
    Contract.all.each do |contract|
      contracts.push(format_contract(contract))
    end
    render json: contracts
  end

  def show
    contract = Contract.find(params[:id])
    render json: format_contract(contract)
  end

  def update
    contract = Contract.find(params[:id])
    contract.update_attributes!(contract_params)
  end

  def nag
    contract = Contract.find(params[:id])
    # send out email remainders
    contract.update_attributes!(nag_count: contract[:nag_count]+1)
    render json: {message: "You've nagged at this applicant for the #{contract[:nag_count]}-th time."}
  end

  private
  def contract_params
    params.permit(:accepted, :withdrawn, :printed)
  end

  def format_contract(contract)
    offer = contract.offer
    contract = contract.as_json
    position = Position.find(offer[:position_id]).as_json
    contract["position"] = position["position"]
    applicant = Applicant.find(offer[:applicant_id]).as_json
    contract["applicant"] = applicant
    contract["deadline"] = (contract["created_at"] + ENV["deadline"].to_i)
    contract["withdrawn"] = Time.now > contract["deadline"]
    return contract
  end

end
