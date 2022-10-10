/*
[1] When ever the class is generated from admin booster there is a prefix that is applied "cls_", delete it.
[2] Assign public to the member classes otherwise you will get error : "Type is not visible : List"
*/



public class OpenCageData{
	public results[] results;
	public status status;
    
	public class results {
		public components components;
		public Integer confidence;	//9
		public String formatted;	//Beryl's Restaurant, Woermann St, Swakopmund 22001, Namibia
		public geometry geometry;
	}
	public class components {
		public String city;	//Swakopmund
		public String continent;	//Africa
		public String country;	//Namibia
		public String country_code;	//na
		public String postcode;	//22001
		public String restaurant;	//Beryl's Restaurant
		public String road;	//Woermann St
		public String state;	//Erongo Region
		public String suburb;	//Central
	}
	public class geometry {
		public Double lat;	//-22.6791826
		public Double lng;	//14.5268016
	}
	public class status {
		public Integer code;	//200
		public String message;	//OK
	}
}