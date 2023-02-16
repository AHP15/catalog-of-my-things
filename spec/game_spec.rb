# ./spec/game_spec.rb
require_relative '../classes/game'
require 'timecop' # The Timecop gem is used to freeze the current time for the duration of each test

describe Game do
  let(:multiplayer) { true }
  let(:last_played_at) { Time.now - (3 * 365 * 24 * 60 * 60) }.to_s
  let(:publish_date) { Time.now - (2 * 365 * 24 * 60 * 60) }.to_s
  let(:game) { Game.new(multiplayer, last_played_at, publish_date) }

  describe '#initialize' do
    it 'sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(multiplayer)
    end

    it 'sets the last_played_at attribute' do
      expect(game.last_played_at).to eq(last_played_at)
    end

    it 'sets the publish_date attribute' do
      expect(game.publish_date).to eq(publish_date)
    end
  end

  describe '#can_be_archived?' do
    context 'when the game is older than 2 years and has not been played in the last 2 years' do
      let(:last_played_at) { Time.now - (3 * 365 * 24 * 60 * 60) }.to_s

      it 'returns true' do
        Timecop.freeze(Time.new(2023, 1, 1)).to_s do
          expect(game.can_be_archived?).to be_truthy
        end
      end
    end

    context 'when the game is older than 2 years but has been played in the last 2 years' do
      let(:last_played_at) { Time.now - (1 * 365 * 24 * 60 * 60) }.to_s

      it 'returns false' do
        Timecop.freeze(Time.new(2023, 1, 1)).to_s do
          expect(game.can_be_archived?).to be_falsy
        end
      end
    end

    context 'when the game is not older than 2 years' do
      let(:publish_date) { Time.now - (1 * 365 * 24 * 60 * 60) }.to_s
      let(:last_played_at) { Time.now - (1 * 365 * 24 * 60 * 60) }.to_s

      it 'returns false' do
        Timecop.freeze(Time.new(2023, 1, 1)).to_s do
          expect(game.can_be_archived?).to be_falsy
        end
      end
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the game object' do
      expected_output = {
        'multiplayer' => multiplayer,
        'last_played_at' => last_played_at,
        'publish_date' => publish_date,
        'class' => 'Game'
      }
      expect(game.to_json).to eq expected_output
    end
  end
end
