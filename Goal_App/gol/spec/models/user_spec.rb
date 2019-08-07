# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
    subject(:user) { User.create(username: 'coolboi', password: '123456' , session_token: 'hjfalfdjskjdfajd', password_digest: 'haldkfshfas') }
 
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:session_token)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}

    
   describe '::find_by_credentials' do
    let(:Jordan) { User.create!(username: 'coolboi420', password: '123456') }
      it 'finds a user by username and password' do
        expect{User.find_by_credentials('coolboi420', '123456')}.to_not raise_error
    end
  end

  describe '#password=()' do
    let(:jordan) { User.create!(username: 'coolboi420', password: '123456', session_token: '63782146783196') }
      it 'encrypt''s a user''s password using BCrypt' do 
        expect(jordan.password_digest).to_not be_nil
    end
  end

  describe '#ensure_session_token' do
    let(:phillip) { User.create!(username: 'coolboi420', password: '123456') }
      it 'ensures that a user''s session token is present and generates a new one if not' do
          expect(phillip.session_token).to_not be_nil
      end
  end

  describe '::generate_session_token' do
    it 'generates a session token for the user' do
      expect(User.generate_session_token).to_not be_nil
    end
  end

  describe '#reset_session_token!' do
    let(:bob) { User.create!(username: 'coolboi420', password: '123456', password_digest: '47829175943201', session_token: '63782146783196') }
      it 'reset the user''s session token, save the user, and return the new session token' do
        bob.reset_session_token!
        expect(bob.session_token).to_not eq('63782146783196')
      end
  end





end











