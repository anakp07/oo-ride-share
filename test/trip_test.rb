require_relative 'test_helper'

describe "Trip class" do
  describe "duration" do
    it "checks the duration of the trip in seconds" do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
      @trip_data = {
          id: 8,
          passenger: RideShare::Passenger.new(
              id: 1,
              name: "Ada",
              phone_number: "412-432-7640"
          ),
          driver: RideShare::Driver.new(
              id: 1,
              name: "Paul Klee",
              vin: "WBF76FYd47DJS7206",
              ),
          start_time: start_time,
          end_time: end_time,
          cost: 23.45,
          rating: 3
      }
      @trip = RideShare::Trip.new(@trip_data)

      expect(@trip.duration).must_equal 1500.0
    end
  end
  describe "initialize" do
    before do

      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
      @trip_data = {
        id: 8,
        passenger: RideShare::Passenger.new(
          id: 1,
          name: "Ada",
          phone_number: "412-432-7640"
        ),
        driver: RideShare::Driver.new(
            id: 1,
            name: "Paul Klee",
            vin: "WBF76FYd47DJS7206",
        ),
        start_time: start_time,
        end_time: end_time,
        cost: 23.45,
        rating: 3
      }
      @trip = RideShare::Trip.new(@trip_data)
    end
    it "raises ArgumentError if end time is BEFORE start time" do

      reverse_start_time = Time.parse('2018-11-24 13:50:31 -0800')
      reverse_end_time = Time.parse('2018-11-24 13:27:30 -0800')

      @trip_data = {
          id: 8,
          passenger: RideShare::Passenger.new(
              id: 1,
              name: "Ada",
              phone_number: "412-432-7640"
          ),
          start_time: reverse_start_time,
          end_time: reverse_end_time,
          cost: 23.45,
          rating: 3
      }

      expect do
        @trip = RideShare::Trip.new(@trip_data)
      end.must_raise ArgumentError
    end

    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end

    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do
      skip # Unskip after wave 2
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end
  end

end


