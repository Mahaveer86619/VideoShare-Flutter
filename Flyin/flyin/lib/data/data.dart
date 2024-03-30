class Video {
  final String author;
  final String title;
  final String description;
  final String duration;
  final String thumbnailUrl;
  final String views;
  final String category;
  final String profileImageUrl =
      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg";
  final String location;
  final String url;
  final DateTime timeStamp;

  const Video({
    required this.author,
    required this.title,
    required this.description,
    required this.duration,
    required this.thumbnailUrl,
    required this.views,
    required this.category,
    required this.location,
    required this.url,
    required this.timeStamp,
  });
}

class Comments {
  final String author;
  final String comment;
  final String profileImageUrl =
      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg";

  const Comments({
    required this.author,
    required this.comment,
  });
}

final List<Comments> comments = [
  const Comments(
    author: "Author1",
    comment:
        "Tysm! this helped me a lot when I was required to do this project <3",
  ),
  const Comments(
    author: "Author2",
    comment: "thank you for the code explanation! very helpful!",
  ),
  const Comments(
    author: "Author3",
    comment: "great video bro I am from software background but i  always have a question about these things that how it work now i understood",
  ),
];

// final List<Video> videos = [
//   Video(
//       id: 1,
//       author: "Author1",
//       title: "Title is a title.",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category1",
//       location: "location",
//       timeStamp: DateTime(2023, 3, 1)),
//   Video(
//       id: 1,
//       author: "Author2",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category2",
//       location: "location",
//       timeStamp: DateTime(2024, 3, 2)),
//   Video(
//       id: 1,
//       author: "Author3",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category3",
//       location: "location",
//       timeStamp: DateTime(2023, 3, 3)),
//   Video(
//       id: 1,
//       author: "Author4",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category4",
//       location: "location",
//       timeStamp: DateTime(2024, 3, 4)),
//   Video(
//       id: 1,
//       author: "Author5",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category5",
//       location: "location",
//       timeStamp: DateTime(2023, 3, 5)),
//   Video(
//       id: 1,
//       author: "Author6",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category6",
//       location: "location",
//       timeStamp: DateTime(2024, 3, 6)),
//   Video(
//       id: 1,
//       author: "Author7",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category7",
//       location: "location",
//       timeStamp: DateTime(2023, 3, 7)),
//   Video(
//       id: 1,
//       author: "Author8",
//       title: "Title is a title",
//       description: "Description is a description",
//       duration: "10.53",
//       thumbnailUrl:
//           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s",
//       views: "100k",
//       category: "Category8",
//       location: "location",
//       timeStamp: DateTime(2024, 3, 8)),
// ];
