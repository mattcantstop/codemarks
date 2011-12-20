class CodemarksController < ApplicationController
  require 'tagger'
  require 'smart_link'
  require 'codemarker'
  include OOPs

  def create
    if params[:second].nil?
      link = Link.find_by_url(params[:url])
      if link
        @new_codemark = Codemark.new(link: link)
        @new_codemark.topics = link.topics
      else
        link = Link.new url: params[:url] 
        link = SmartLink.new(link).better_link
        @new_codemark = Codemark.new(link: link)
        @new_codemark.topics = Tagger.get_tags_for_link link if link.response
        @new_codemark.link.valid?
      end

      render do |format|
        format.js
      end
    else
      @codemark = Codemark.new
      link_id = params[:codemark][:link][:id]
      if link_id.present?
        @codemark.link = Link.find params[:codemark][:link][:id]
      else
        @codemark.link = Link.new params[:codemark][:link]
      end
      @codemark.user = current_user
      @codemark.topics = Topic.find params[:topic_ids].keys
      if Codemarker.mark! @codemark
        redirect_to dashboard_path, notice: "Codemark created"
      else
        redirect_to dashboard_path, notice: "Sorry, something went wrong"
      end
    end
  end
end
