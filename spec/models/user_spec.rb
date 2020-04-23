RSpec.describe User, :type => :model do
  context "validate user" do
    let(:user) { create :user }
    it 'valid user' do
      expect(user.valid?).to eq true
    end

    context 'invalid user' do
      it 'empty user name' do
        user.username = nil
        expect(user.valid?).to eq false
      end

      it 'empty password' do
        user.password = nil
        expect(user.valid?).to eq false
      end

      it 'password different with password confirmation' do
        user.password = 'password'
        user.password_confirmation = 'password1'
        expect(user.valid?).to eq false
      end
    end
  end
end