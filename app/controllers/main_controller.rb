class MainController < ApplicationController
  def index
    @organizations= Organization.find_by_tags(params[:q].to_s.strip,params[:type].to_s.strip).
                        includes(:contacts).paginate(:page=>params[:page],:per_page=>6)
  end
end
