class Option {
  final int index;
  final String title;
  final String voteType;

  Option(this.index, this.title, this.voteType);
}

class VotingResult {
  var votenotAcceptableVotes;
  var poorVotes;
  var challengesVotes;
  var commendableVotes;
  var excellentVotes;
  var voters;
}
