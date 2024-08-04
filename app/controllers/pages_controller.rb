# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :load_page, only: %i[show edit update destroy]

  def index
    authorize Page
    @pages = scope.page(params[:page])
    @breadcrumbs = :pages
  end

  def show
    @children = policy_scope(Page).where(page: @page)
    @breadcrumbs = @page
  end

  def new
    @page = authorize scope.new
    @breadcrumbs = [@page, :new]
  end

  def create
    @page = authorize scope.new(page_params)

    if @page.save
      redirect_to @page, notice: t(".notice")
    else
      flash.now.alert = @page.alert
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @breadcrumbs = [@page, :edit]
  end

  def update
    if @page.update(page_params)
      redirect_to page_path(@page), notice: t(".notice")
    else
      flash.now.alert = @page.alert
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page.destroy!

    reset_session

    redirect_to root_path, notice: t(".notice")
  end

  def destroy_all
    authorize Page

    scope.destroy_all

    reset_session

    redirect_back_or_to(root_path)
  end

  private

  def load_page
    @page = authorize scope.find_by!(slug: params[:id])
  end

  def scope
    policy_scope(Page)
  end

  def page_params
    params.require(:page).permit(:page_id, :title, :slug, :body)
  end
end
