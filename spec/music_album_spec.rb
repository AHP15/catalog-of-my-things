require_relative './helper_spec.rb'

describe MusicAlbum do
  before :all do
    @music_album = MusicAlbum.new('2023/02/14', false)
  end

  it 'should initialize instance' do
    expect(@music_album).to be_an_instance_of(MusicAlbum)
  end

  it 'should return whether it can be archeived' do
    # Acc
    is_archeived = @music_album.can_be_archived?

    # Assertion
    expect(is_archeived).to eq(false)
  end

  it 'should return a hash' do
    # Act
    hash = @music_album.to_hash

    # Assertions
    expect(hash.key?('id')).to eq(true)
    expect(hash.key?('on_spotify')).to eq(true)
    expect(hash.key?('publish_date')).to eq(true)
  end
end
