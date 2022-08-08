abstract class BmiEvent {}

class ShowResult extends BmiEvent {
  final double weight;
  final double height;

  ShowResult(this.height, this.weight);
}