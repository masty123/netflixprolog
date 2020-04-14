:- load_files(netflix_facts,[]).

% for ignore warning
:- dynamic 
    kidmedia/1,
    maturemedia/1,
    isclassic/1,
    mateage/2, 
    releaseYear/1, 
    matage/1, 
    type/1, 
    isFrom/1,
    director/2,
    similarfamilyshow/2,
    actor/3.
:- discontiguous actor/3.
:- style_check(-singleton).

%member:
%theeruth   borisuth        5910545701
%phanuwatch luangpradit     5910545779
%patiphan   srisook         5910546422
%tetach     rattanavikran   6110545554
%punyawee   srithongkerd    6110545571

% topic:_Watching_Netflix

%_source_reference:
%_Netflix.com
%_https://www.wired.co.uk/article/best-shows-netflix
%_https://www.radiotimes.com/news/on-demand/2020-02-11/netflix-best-movies/?

%_competency_Question:

% Kid-friendly media?
% Classic_media?
% Latest medias in Netflix?
% An anime or not?
% Similar media with the same age restriction?
% Director that directed a movie that this specific actor appear
% An co-stars of a specific director in a specific movie.  
% Director that direct movie for mature audiance
% actors in a classic media.
% Specific mature movies with specific type that release in a specific year.
% Director that used to direct a classic media.


% rules:questions_converted_into_code

% ISSUE 1: Use constant for age instant of variable.
% COMPLETED: We can only use constant on some cases, there are some cases that cannot be changed like isClassic(X), kidMedia, and teenMedia.

% Is this media a classic?
isClassic(MEDIA) :-
    releaseYear(MEDIA, YEAR),
    YEAR=<2000.

% New movie/series that came out this year.
newMedia(MEDIA) :-
    releaseYear(MEDIA, 2020).
                                     
% Can kid watch this media?                
kidMedia(MEDIA) :-                         
    matage(MEDIA, AGE),                    
    AGE =< 13.                             
                                                                                                                             
% A media for mature audience only         
matureMedia(MEDIA) :-                      
    matage(MEDIA, 18).                     
                                           
% We've added this rule to handle media that have age between 13 - 18.
teenMedia(MEDIA) :-                      
    matage(MEDIA, AGE),
    AGE > 13,
    AGE < 18.  

% Is this media an anime?
isAnime(ANIME) :-
    type(ANIME, animation),
    isfrom(ANIME, japan).

% ISSUE 2: Convert similarFamilyShow and similarMatureShow into one rule.
% COMPLETED: Deleted similarFamilyShow and similarMatureShow because it can be converted into one rule.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                                                                        %
% Similar show for with age restrict checking.                                                          %
similarShow(MEDIA_X, MEDIA_Y) :-                                                                        %
    % Fixed at this below column. use OR instead of 2 rules                                             %
    (   matureMedia(MEDIA_X),                                                                           %
        matureMedia(MEDIA_Y)                                                                            %
    ;   kidMedia(MEDIA_X),                                                                              %
        kidMedia(MEDIA_Y)                                                                               %
    ;   teenMedia(MEDIA_X),                                                                             %
        teenMedia(MEDIA_Y)                                                                              %
    ),                                                                                                  %
    type(MEDIA_X, TYPE),                                                                                %
    type(MEDIA_Y, TYPE),                                                                                %
    MEDIA_X\=MEDIA_Y,                                                                                   %
    nl,                                                                                                 %                
    print(type:TYPE),                                                                                   %
    nl.                                                                                                 %
                                                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Director that direct media for mature audience
matureDirector(MEDIA,DIRECTOR) :-
    matureMedia(MEDIA),
    director(MEDIA,DIRECTOR),
    nl.

% Director that directed a media that this specific actor appear
mediaDirectorwithActor(DIRECTOR,ACTOR) :-
    director(MEDIA,DIRECTOR),
    actor(MEDIA, ACTOR, ROLE),
    nl,
    print(media: MEDIA),
    nl.

% Co-star of an actor in this media. 
coStar(ACTOR_1,ACTOR_2) :-
    actor(MEDIA,ACTOR_1,ROLE_1),
    actor(MEDIA,ACTOR_2,ROLE_2),
    ACTOR_1 \= ACTOR_2,
    nl,
    print(media: MEDIA),
    nl.

% Actor in a classic media.
actorinClassicMedia(ACTOR,MEDIA) :-
    isClassic(MEDIA),
    actor(MEDIA, ACTOR, ROLE),
    nl.

% Specific medias with specific type that release in a specific year.
matureTypeMediainYear(MEDIA,TYPE,YEAR) :-
    type(MEDIA,TYPE),
    matureMedia(MEDIA),
    releaseYear(MEDIA,YEAR),
    nl.
    
% Director that used to direct a classic media.
classicDirector(DIRECTOR,MEDIA) :-
    isClassic(MEDIA),
    director(MEDIA,DIRECTOR),
    nl.

    
  


