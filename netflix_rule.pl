:- load_files(netflix_facts,[]).

:- dynamic 
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
   
% rules:_converted_into_code

% Is this media a classic?
isclassic(MEDIA) :-
    releaseYear(MEDIA, YEAR),
    YEAR=<2000,
    nl.

% Can kid watch this media?
kidmedia(MEDIA) :-
    matage(MEDIA, AGE),
    AGE=<13,
    nl.

% A media for mature audience only
maturemedia(MEDIA) :-
    matage(MEDIA, AGE),
    AGE>=18,
    nl.

% Is this media an anime?
isanime(ANIME) :-
    type(ANIME, TYPE),
    TYPE==animation,
    isfrom(ANIME, LOCATION),
    LOCATION==japan,
    nl.

% Similar family show
similarfamilyshow(MEDIA_X, MEDIA_Y) :-
    kidmedia(MEDIA_X),
    kidmedia(MEDIA_Y),
    type(MEDIA_X, TYPE_A),
    type(MEDIA_Y, TYPE_A),
    MEDIA_X\=MEDIA_Y,
    nl.

% Similar show for mature audiences
similarmatureshow(MEDIA_X, MEDIA_Y) :-
    maturemedia(MEDIA_X),
    maturemedia(MEDIA_Y),
    type(MEDIA_X, TYPE),
    type(MEDIA_Y, TYPE),
    MEDIA_X\=MEDIA_Y,
    nl.

% Director that direct media for mature audience
maturedirector(MEDIA,DIRECTOR) :-
    maturemedia(MEDIA),
    director(MEDIA,DIRECTOR),
    nl.

% Director that directed a movie that this specific actor appear
moviedirectorwithactor(DIRECTOR,ACTOR,MOVIE) :-
    director(MOVIE,DIRECTOR),
    actor(MOVIE, ACTOR, ROLE),
    nl.

% Co-star of an actor in this movie. 
costar(ACTOR_1,ACTOR_2,MEDIA) :-
    actor(MEDIA,ACTOR_1,ROLE_1),
    actor(MEDIA,ACTOR_2,ROLE_2),
    ACTOR_1 \= ACTOR_2,
    nl.

% Actor in a classic media.
actorinclassicmedia(ACTOR,MOVIE) :-
    isclassic(MOVIE),
    actor(MOVIE, ACTOR, ROLE),
    nl.

% Specific medias with specific type that release in a specific year.
maturetypemovieinYear(MEDIA,TYPE,YEAR) :-
    type(MEDIA,TYPE),
    maturemedia(MEDIA),
    releaseYear(MEDIA,YEAR).
    
% New movie/series that came out this year.
newmedia(MEDIA) :-
    releaseYear(MEDIA, YEAR),
    YEAR==2020,
    nl.

% Director that used to direct a classic movie.
classicdirector(DIRECTOR,MEDIA) :-
    isclassic(MEDIA),
    director(MEDIA,DIRECTOR),
    nl.

% Similar Director that direct a mature and classic media.
similarclassicmaturedirector(DIRECTOR, MEDIA_Y) :-
    similarmatureshow(MEDIA_X, MEDIA_Y),
    isclassic(MEDIA_X),
    director(MEDIA_X,DIRECTOR),
    nl.
    
    
  



