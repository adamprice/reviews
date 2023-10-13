#if DEBUG
import Foundation

enum ReviewStubData {

    static let reviews: [Review] = {
        try! JSONDecoder().decode(ReviewsResponse.self, from: ReviewStubData.reviewsJSON.data(using: .utf8)!).reviews
    }()

    static let reviewsJSON = """
    {
        "reviews": [
            {
                "id": "Gylq7ADLHh595tz2pyW4CA",
                "url": "https://www.yelp.com/biz/playa-cabana-toronto?adjust_creative=PQVS3ONnOnj28MY1lNz-_g&hrid=Gylq7ADLHh595tz2pyW4CA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=PQVS3ONnOnj28MY1lNz-_g",
                "text": "Beautiful little neighbourhood gem! The patio was open tonight and we took full advantage, living out our taco dreams. \\n\\nWe ordered the whole menu...",
                "rating": 5,
                "time_created": "2023-05-07 11:29:31",
                "user": {
                    "id": "oPzFN6yGnhQL051ws3a17A",
                    "profile_url": "https://www.yelp.com/user_details?userid=oPzFN6yGnhQL051ws3a17A",
                    "image_url": "https://s3-media3.fl.yelpcdn.com/photo/SCC5zDBmAbeH2gdkYIEHNQ/o.jpg",
                    "name": "Reh L."
                }
            },
            {
                "id": "IOyQiOr_I3k6DGmaFXLoSQ",
                "url": "https://www.yelp.com/biz/playa-cabana-toronto?adjust_creative=PQVS3ONnOnj28MY1lNz-_g&hrid=IOyQiOr_I3k6DGmaFXLoSQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=PQVS3ONnOnj28MY1lNz-_g",
                "text": "The crispy tacos were so good, the soft chicken ones were average. The corn was very nice as well. The food was good I don't know if I would necessarily...",
                "rating": 3,
                "time_created": "2023-07-09 19:51:46",
                "user": {
                    "id": "mdIPaz9_Lw0v3sz3QCf2MA",
                    "profile_url": "https://www.yelp.com/user_details?userid=mdIPaz9_Lw0v3sz3QCf2MA",
                    "image_url": "https://s3-media1.fl.yelpcdn.com/photo/d4OGdQ4asShVPDYUvvV9Xw/o.jpg",
                    "name": "Rea H."
                }
            },
            {
                "id": "tawAZo1lr6CEWreQHsC77g",
                "url": "https://www.yelp.com/biz/playa-cabana-toronto?adjust_creative=PQVS3ONnOnj28MY1lNz-_g&hrid=tawAZo1lr6CEWreQHsC77g&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_reviews&utm_source=PQVS3ONnOnj28MY1lNz-_g",
                "text": "The food was fresh and very delicious! I gave it 4 stars because the place is way too crowded, the space is tight and it was way too loud! You could barely...",
                "rating": 4,
                "time_created": "2023-09-27 23:18:52",
                "user": {
                    "id": "6oRbFgVQa5YWzNQ6l4YzNQ",
                    "profile_url": "https://www.yelp.com/user_details?userid=6oRbFgVQa5YWzNQ6l4YzNQ",
                    "image_url": null,
                    "name": "Gilou C."
                }
            }
        ],
        "total": 475,
        "possible_languages": [
            "en"
        ]
    }
    """
}
#endif
