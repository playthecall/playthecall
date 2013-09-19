# encoding: utf-8
require 'factory_girl'
require './spec/factories/missions'

game_versions = [
  [{ name: 'Brasil', language: 'pt-BR'}, { name: 'Capítulo I - Despertar' }],
  [{ name: 'Global', language: 'en'   }, { name: 'Chapter I - Awakening'  }],
  [{ name: 'USA',    language: 'us'   }, { name: 'Chapter I - Awakening'  }],
  [{ name: 'China',  language: 'cn'   }, { name: 'Nissim I - Miojo'       }],
  [{ name: 'India',  language: 'in'   }, { name: 'Hare I - Krisha Hare!'  }]
]

game_versions.each do |game_params, chapter_params|
  version = GameVersion.create game_params
  chapter = version.chapters.create chapter_params

  (1..5).each do |n|
    FactoryGirl.create :mission,
      slug:        "mission-#{n}",
      chapter:     chapter,
      position:    n,
      description: "# Mission #{n}\n\n## Version #{ version.name }\n\n## Chapter #{ chapter.name }\n\n#{Forgery(:lorem_ipsum).words(64)}\n\n#{Forgery(:lorem_ipsum).words(64)}\n\n#{Forgery(:lorem_ipsum).words(64)}"
  end
end

