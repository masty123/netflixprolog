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
% Latest movies in Netflix?
% An anime or not?
% Similar media with the same age restriction?
% Director that directed a movie that this specific actor appear
% An co-stars of a specific director in a specific movie.  
% Director that direct movie for mature audiance
% actors in classic a media.
% co-star in a movie?
% Specific mature  movies with specific type that release in a specific year.
% Director that used to direct a classic media.
   
:- load_files(netflix_facts,[]).

:- dynamic 
    mateage/2, 
    releaseYear/1, 
    matage/1, 
    type/1, 
    isFrom/1,
    director/2,
    actor/3.
:- discontiguous actor/3.
:- style_check(-singleton).
 
% rules:_converted_into_code
% Is this media a classic?
isclassic(X) :-
    releaseYear(X, Y),
    Y=<2000.

% Can kid watch this media?
kidmedia(X) :-
    matage(X, Y),
    Y=<13.

% A media for mature audience only
maturemedia(X) :-
    matage(X, Y),
    Y>=18.

% Is this media an anime?
isanime(X) :-
    type(X, Z),
    Z==animation,
    isfrom(X, Y),
    Y==japan.

% Similar family show
similarfamilyshow(W, V) :-
    kidmedia(W),
    kidmedia(V),
    type(W, X),
    type(V, X),
    W\=V.

% Similar show for mature audiences
similarmatureshow(W, V) :-
    maturemedia(W),
    maturemedia(V),
    type(W, X),
    type(V, X),
    W\=V.

% Director that direct media for mature audience
maturedirector(V,W) :-
    maturemedia(V),
    director(V,W).

% Director that directed a movie that this specific actor appear
moviedirectorwithactor(D,A) :-
    director(M,D),
    actor(M, A, X).

% Co-star of an actor in this movie. X = costar #1, Y = costar #2, Z = Movies
costar(X,Y,Z) :-
    actor(Z,X,C),
    actor(Z,Y,D),
    X \= Y.

% Actor in a classic media.
actorinclassicmedia(X,Y) :-
    isclassic(Y),
    actor(Y, X, C).

% Specific medias with specific type that release in a specific year.
maturetypemovieinYear(M,T,Y) :-
    type(M,T),
    maturemedia(X),
    releaseYear(M,Y).
    
% New movie/series that came out this year.
newmedia(X) :-
    releaseYear(X, Y),
    Y==2020.

% Director that used to direct a classic movie.
classicdirector(X,Y) :-
    isclassic(Y),
    director(Y,X).



