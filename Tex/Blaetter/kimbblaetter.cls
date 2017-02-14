%
%	LaTex Klasse fuer Uebungszettel
%		by KIMB-technologies 
%	
%	Version: 1.0 Alpha
%	Started: 11.11.2016
%	Last changed: 14.02.2017
%
%	Released under terms of
%		GPLv3
%	See https://www.gnu.org/licenses/gpl-3.0.txt
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Klasse
%		Pakete laden
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Format
\NeedsTeXFormat{LaTeX2e}

%Klassenname und Beschreibung
\ProvidesClass{kimbblaetter}

%%Grundsystem
\LoadClass{scrartcl}

%Schrift
\renewcommand*{\familydefault}{\sfdefault}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[scaled=1]{helvet} %Schriftart
\RequirePackage{courier} % Schönere Schriftart für nicht proportionale Schrift laden

%Umlaute etc.
\usepackage[utf8]{inputenc}

%Deutsch
\RequirePackage[ngerman]{babel} % neue deutsche Trennungsregeln, etc

%Seitenlayout
\RequirePackage[bottom=30pt,
	top=30pt,
	left=60pt,
	includeheadfoot]{geometry}
	
%Bilder
\RequirePackage{graphicx}
%Mathe
\RequirePackage{amssymb, amsfonts, amsthm, amsmath, float}
%Seite von X moeglich machen
\RequirePackage{lastpage}
%Zahlen schön anzeigen moeglich
\RequirePackage{numprint}

%Tikz
\RequirePackage{tikz}
\RequirePackage{tkz-fct}
\usetikzlibrary{shapes.misc}
\usetikzlibrary{shapes, calc, shapes, arrows}
%Graphenplotter
\RequirePackage{pgfplots}

%Blitz (\lightning) und Durchstreichen (\st{})
\RequirePackage{stmaryrd, soul}

%Farben
\RequirePackage{color}

% Quellcode
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{textcomp}

\definecolor{pblue}{rgb}{0.13,0.13,1}
\definecolor{pgreen}{rgb}{0,0.5,0}
\definecolor{pred}{rgb}{0.9,0,0}
\definecolor{pgrey}{rgb}{0.46,0.45,0.48}
\definecolor{bgrey}{rgb}{0.95,0.95,0.95}
\lstset{
	language=Java,
	showspaces=false,
	showtabs=false,
	breaklines=true,
	commentstyle=\color{pgreen},
	keywordstyle=\color{pblue},
	stringstyle=\color{pred},
	%basicstyle=\ttfamily,
	basicstyle=\footnotesize\ttfamily,
	morecomment=[l]{//},
	morekeywords={for,to,while,do,if,then,else,T,String},
	mathescape=true,
	backgroundcolor=\color{bgrey},
	numbers=left,
	numberstyle=\tiny,
	frame=rb,
	tabsize=2,
	showstringspaces=false
}

%Zeiten
\RequirePackage[ddmmyyyy,hhmmss]{datetime}

%Header und Footer änderbar
\RequirePackage{fancyhdr}  
 
% Wasserzeichen fuer Betas
\RequirePackage{draftwatermark}
 
% PDF Meta und Hyperlinks
\RequirePackage[
	pdftitle={ KIMB Übungszettel Klasse },
	colorlinks,
	linkcolor={black},
	citecolor={black},
	urlcolor={blue}
]{hyperref}
\pdfcompresslevel=9
\pdfobjcompresslevel=9

%Zufallszahlen
\RequirePackage[first=0, last=99999]{lcg}

%Kreuz und Haken Symbol (richtig, falsch)
%	http://ctan.org/pkg/pifont
\RequirePackage{pifont}

%Schoenere Listen
\RequirePackage{enumerate}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Alle Pakete geladen
%		Seiteneinstellungen machen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Klassenfunktionen
%	Vorgaben
\def\zettelFach{Mein Fach}
\def\zettelAuthor{Max Mustermann}
\def\zettelStudents{Max Mustermann 000000 - Otto Müller 000000}
\def\zettelGruppe{Gruppe 0}
\def\zettelNummer{20}
% 	Ueberschreiben
%		Fach
\newcommand{\defineFach}[1]{
	\edef\zettelFach{#1}
}
%		Autor (Hauptperson)
\newcommand{\defineAuthor}[1]{
	\edef\zettelAuthor{#1}
}
%		Gruppennamen
\newcommand{\defineStudents}[1]{
	\edef\zettelStudents{#1}
}
%		Gruppe
\newcommand{\defineGruppe}[1]{
	\edef\zettelGruppe{#1}
}
%		Blattnummer
\newcommand{\defineNummer}[1]{
	\edef\zettelNummer{#1}
}

%Seiten Header und Footer nach Funktion aufbauen
\pagestyle{fancy} 
\cfoot{ }
\renewcommand{\footrulewidth}{0.4pt}

%Layout nach Wünschen anpassen
\newcommand{\regenerateLayout}{
	%Seitenheader und Footer
	%	Mode Namen oben?
	\ifx\modeUP\undefined
		%Draft or Final
		\ifx\outFinal\undefined
			\rfoot{ Keine Weitergabe, Veröffentlichung oder Plagiierung! \\ \copyright ~ \zettelAuthor ~ \today }	
			\lfoot{ Seite \thepage ~von \pageref{LastPage} \\ \rand\arabic{rand} } 
		\else
			\rfoot{ \zettelStudents }  
			\lfoot{ Seite \thepage ~von \pageref{LastPage} } 		
		\fi

		\lhead{ \textbf{ \zettelFach } }
		\chead{ Übungsblatt \zettelNummer }
		\rhead{ \textit{ \zettelGruppe } }
	\else
		%Draft or Final
		\ifx\outFinal\undefined
			\rhead{ Keine Weitergabe, Veröffentlichung oder Plagiierung! \\ \copyright ~ \zettelAuthor ~ \today }	
			\lfoot{ Seite \thepage ~von \pageref{LastPage} \\ \rand\arabic{rand} } 
		\else
			\rhead{ \textit{ \zettelGruppe } \\ \zettelStudents }  		
			\lfoot{ Seite \thepage ~von \pageref{LastPage} } 
		\fi
		\rfoot{ \textbf{ \zettelFach } }
		\chead{}
		\lhead{ Übungsblatt \zettelNummer }
	\fi
	
	%Wasserzeichen
 	%	Draft oder Final
 	\ifx\outFinal\undefined
			%Spaetere Weitergabe?
			\ifx\laterPub\undefined
				%Wasserzeichen setzen
				\SetWatermarkText{ ENTWURF }
				\SetWatermarkScale{1}
			\else
				%Kein Wasserzeichen
				\SetWatermarkText{}
				\SetWatermarkScale{0}
			\fi
 	\else
		%Kein Wasserzeichen
 		\SetWatermarkText{}
 		\SetWatermarkScale{0}
 	\fi
}

% Erstmal Standard machen
\regenerateLayout
% Layout des Headers, Footers ändern (Namen oben)
\newcommand{\rearrangeUp}{
	\def\modeUP{1}
	\regenerateLayout
}
%Finale Ausgabe machen
\newcommand{\outputFinal}{
	\def\outFinal{1}
	\regenerateLayout
}
%Spaetere Weitergabe
\newcommand{\laterPublish}{
	\def\laterPub{1}
	\regenerateLayout
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Nützliche Funktionen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tabelle Zelle mit mehreren Zeilen
\newcommand{\specialcell}[2][c]{%
  \begin{tabular}[#1]{@{}c@{}}#2\end{tabular}}
  
%Aufgaben Überschrift
\newcommand{\aufgabe}[1]{
	\section*{ #1 }
}

%Kommentare blau
\newcommand{\kommentar}[1]{
	\ifx\outFinal\undefined
		{\color{blue} #1 \\}
	\fi
}
%Vorläufiges und unsicheres rot
\newcommand{\showbeta}[1]{
	\ifx\outFinal\undefined
		{\color{red} #1}
	\else
		#1
	\fi
}

%Fehlerberichtigenungen in grün
\newcommand{\fixed}[1]{
	{\color{green} #1 }
}

%Beweisbox
\newcommand{\beweisbox}{
	{\flushright $\hfill \Box$ }
}

%Kreuz fuer korrekt
\newcommand{\kreuzf}{\ding{55}}
%Haken fuer inkorrekt
\newcommand{\hakenw}{\ding{51}}
%Unter Verwendung von pifont (http://ctan.org/pkg/pifont)

%Schneller inline Code
\newcommand{\code}[1]{ \lstinline~ #1 ~}

%Box fuer Definitionen
\newcommand{\defbox}[2]{
	\fcolorbox{#1}{gray!10}{
		\parbox{\textwidth}{
			#2
		}
	}
}

%Mathekram
	% griech. Buchstaben fuer Vektorräume
	\renewcommand{\a}{\alpha}
	\renewcommand{\b}{\beta}
	\newcommand{\g}{\gamma}
	%Koerper K
	\newcommand{\K}{\mathbb{K}}
	\newcommand{\R}{\mathbb{R}}
	\newcommand{\C}{\mathbb{C}}
	\newcommand{\N}{\mathbb{N}}
	% Norm
	\newcommand{\norm}[1]{ \left\lVert #1 \right\rVert }
	%Skalarprodukt
	\newcommand{\skalar}[2]{ \left\langle #1, #2 \right\rangle}
	%Landau O
	\newcommand{\landau}{ \mathcal{O} }
	\newcommand{\smallLandau}{ { \scriptscriptstyle\mathcal{O} } }
	%Vektoren
	\renewcommand{\vec}[1]{ { \color{blue} \overrightarrow{ { \color{black} #1 } } } }
	\newcommand{\lvec}[1]{ { \color{red} \overleftarrow{ { \color{black} #1 } } } }

% Info ueber die Klasse
\newcommand{\showinfo}{
	%Hinweiskommentar
	\kommentar{
		{\huge{ \textbf{Hinweise zur Klasse:}}}
		\begin{description}
			\item[Modi] \hfill \\
				Die Klasse ist normalerweise im Entwurfsmodus und zeigt
				die Namen unten rechts an.\\
				Mit \underline{\textbackslash rearrangeUp} werden die Namen nach oben rechts geschoben.\\
				Mit \underline{\textbackslash outputFinal} wird der Entwurfsmodus verlassen (in den Abgabemodus).\\
				Mit \underline{\textbackslash laterPublish } wird ein Weitergabemodus gewaehlt.\\
				\textit{Befehle einfach in die Präambel einfügen.}
			\item[Angaben] \hfill \\			
				\underline{\textbackslash defineFach\{ Mein Fach \}} \\
				\underline{\textbackslash defineAuthor\{ Mein Name \}} \textit{Name auf Entwürfen} \\
				\underline{\textbackslash defineStudents\{ Mein Name 000000 - Weitere Namen 000000\}} \\
				\underline{\textbackslash defineGruppe\{Meine Abgabegruppe 0\}} \\
				\underline{\textbackslash defineNummer\{ 2 \}} \textit{Nummer des Blattes} \\
			\item[Commands] \hfill \\
				\underline{\textbackslash specialcell\{Tabellenzelle \textbackslash\textbackslash mit Umbruch \} } \\
				\underline{\textbackslash aufgabe\{Übung 2\} } \\
				\underline{\textbackslash beweisbox } \\
				\underline{\textbackslash kreuzf, \textbackslash hakenw } \kreuzf, \hakenw \\
				\underline{\textbackslash code \{ echo "Hallo Welt!" \} } \code{ echo "Hallo Welt!" } \\
				\underline{\textbackslash defbox\{farbe\}\{ Eine grau hinterlegte Box mit farbigem Rand \} }
			\item[Mathematikfeatures] \hfill \\
				\underline{ \textbackslash a, \textbackslash b, \textbackslash g,  } $\a, \b, \g$\\
				\underline{ \textbackslash K, \textbackslash C, \textbackslash R, \textbackslash N } $\K, \R, \C, \N$ \\
				\underline{ \textbackslash norm \{ v \}, \textbackslash skalar \{ v \}\{ w \}  } $\norm{v}, \skalar{v}{w}$\\
				\underline{ \textbackslash landau, \textbackslash smallLandau, \textbackslash vec\{ v \}, \textbackslash lvec\{ w \} } $ \landau, \smallLandau, \vec{ v }, \lvec{w} $
			\item[Kommentar] \hfill \\ 
				Anmerkungen als blauer Text, werden bei Veröffentlichung ausgeblendet. \\
				\underline{\textbackslash kommentar\{ hier rein \}}
			\item[Beta] \hfill \\
				Unfertige Lösungen als roter Text, werden bei Veröffentlichung schwarz. \\
				\underline{\textbackslash showbeta\{ hier rein \}}
			\item[Korrektur] \hfill \\
				Spätere Korrekturen als grüner Text. \\
				\underline{\textbackslash fixed\{ hier rein \}}
		\end{description}
		Dieser Hinweis ist ein Kommentar und wird mit \underline{\textbackslash showinfo} angezeigt.
	}
}