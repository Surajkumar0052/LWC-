trigger OpportunitiesInAccount on Opportunity (before insert) {
    List<Opportunity> opp = Trigger.new;
    opportunityLimit.oppMethod(opp);
}