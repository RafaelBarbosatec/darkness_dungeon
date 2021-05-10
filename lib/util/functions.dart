import '../main.dart';

const TILE_SIZE_SPRITE_SHEET = 16;

double valueByTileSize(double value) {
  return value * (tileSize / TILE_SIZE_SPRITE_SHEET);
}
