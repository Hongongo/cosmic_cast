import 'package:cosmic_cast/domain/entities/actor.dart';
import 'package:cosmic_cast/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath:  (cast.profilePath != '')
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=',
        character: cast.character,
      );
}
