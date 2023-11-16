# frozen_string_literal: true

require 'rails_helper'

describe '管理者側のテスト' do
  describe '管理者ログイン前のテスト' do
    before do
      visit new_admin_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end

  describe '管理者ログイン' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
    end
  end
end