class Profile{
  String name;
  String imagePath;
  String country;
  String city;
  int followers;
  int posts;
  int following;

  Profile({this.name, this.imagePath, this.country, this.city, this.followers, this.following, this.posts});

}

final List<Profile> profiles = [
  Profile(
    imagePath: "assets/messi.jpg",
    name: "Lionel Messi",
    country: "Argentina",
    city: "Barcelona",
    followers: 1000,
    following: 20,
    posts: 11
  ),
  Profile(
      imagePath: "assets/ronaldo.jpg",
      name: "Christiano Ronaldo",
      country: "Argentina",
      city: "Barcelona",
      followers: 1000,
      following: 20,
      posts: 11
  ),
  Profile(
      imagePath: "assets/salah.jpg",
      name: "Mo salah",
      country: "Argentina",
      city: "Barcelona",
      followers: 1000,
      following: 20,
      posts: 11
  ),
];