require "rails_helper"

describe "Plots Index Page" do
  before :each do
    @garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    
    @plot_1 = @garden_1.plots.create!(number: 25, size: "Large", direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 20, size: "Medium", direction: "West")

    @bell = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @pepper = Plant.create!(name: "Banana pepper", description: "Prefers heat and a long growing season.", days_to_harvest: 70)
    
    @sweet = Plant.create!(name: "Sweet Potato", description: "Prefers warm weather and warm soil.", days_to_harvest: 85)

    PlantPlot.create!(plant: @bell, plot: @plot_1)
    PlantPlot.create!(plant: @pepper, plot: @plot_1)

    PlantPlot.create!(plant: @sweet, plot: @plot_2)
    
  end

  describe "As a visitor when vivsitng the plots index page" do 
    it "has a list of all plot numbers" do 
      visit plots_path

      expect(page).to have_content(@plot_1.number)
      expect(page).to have_content(@plot_2.number)
    end

    it "has the names of all the plots plants under the number" do 
      visit plots_path

      within("#plot-#{@plot_1.number}") do 
        expect(page).to have_content(@bell.name)
        expect(page).to have_content(@pepper.name)
      end

      within("#plot-#{@plot_2.number}") do 
        expect(page).to have_content(@sweet.name)
      end
    end
  end
end