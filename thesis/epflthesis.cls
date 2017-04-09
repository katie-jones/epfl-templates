\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epflthesis}[2016/07/25 v1 EPFL Thesis class]

\RequirePackage{setspace}
\RequirePackage{lmodern}
\RequirePackage{calc}
\RequirePackage{fancyhdr}
\RequirePackage[strict]{changepage}

% Option for no abstract
\newif\ifabstract
\abstracttrue
\DeclareOption{noabstract}{\abstractfalse}

%abstract
\long\def\@abstract{\@latex@error{No \noexpand\abstract given}\@ehc}

%frontmatter numbered with roman numerals, mainmatter with arabic
\newcommand*{\frontmatter}{\pagenumbering{roman}}
\newcommand*{\mainmatter}{\pagenumbering{arabic}}
\newcommand*{\backmatter}{\pagenumbering{Roman}}

\newcommand*{\makelot}{}
\newcommand*{\makelof}{}
\newcommand*{\makelos}{}

\newcommand*{\begincmd}{
  \onehalfspacing
  \frontmatter\maketitlepage\makeabstract
  \makeacknowledgements\makededication\tableofcontents\clearpage
  \makelot\clearpage\makelof\clearpage\makelos
  \cleardoublepage\mainmatter
  \renewcommand{\baselinestretch}{1.5}
  \formatheaders
}
\newcommand{\@printlos}{}

\newif\ifdoubleheaders
\doubleheadersfalse
\DeclareOption{doubleheaders}{\doubleheaderstrue}
\newcommand*{\formatheaders}{
  \pagestyle{fancy}
  \fancyhf{}
  \if@twoside
  \fancyhead[OR]{\bfseries \nouppercase{\rightmark}}
  \fancyhead[EL]{\bfseries \nouppercase{\leftmark}}
  \fancyfoot[EL,OR]{\thepage}
  \else
  \ifdoubleheaders
  \fancyhead[L]{
    \checkoddpage
    \ifoddpage
    \bfseries \nouppercase{\rightmark}
    \else
    \bfseries \nouppercase{\leftmark}
    \fi
  }
  \fancyfoot[L]{\thepage}
  \else
  \fancyhead[L]{\bfseries\nouppercase{\leftmark}}
  \fi
  \fi
}

\def\headrule{\color{darkgray}{\hrule\@height\headrulewidth\@width\headwidth \vskip-\headrulewidth}}

%define required vars
\def\@deptpref{Department of}
\def\departmentprefix#1{\gdef\@deptpref{#1}}
\def\printlos#1{\gdef\@printlos{#1}}
\def\@advisorpref{Supervisors:~}
\def\advisorprefix#1{\gdef\@advisorpref{#1}}
\def\advisor#1{\gdef\@advisor{#1}}
\gdef\@school{Ecole polytechnique fédérale de Lausanne}
\def\school#1{\gdef\@school{#1}}
\def\dept#1{\gdef\@dept{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\long\def\acknowledgements#1{\gdef\@acknowledgements{#1}}

%define optional vars
\def\city#1{\gdef\@city{#1}}
\def\dedication#1{\gdef\@dedication{#1}}
\def\extranotes#1{\gdef\@extranotes{#1}}
\def\logo#1{\gdef\@logo{#1}}
\extranotes{}
\city{}

% define abstract titles
% commmand \abstractname already contains name for abstract A
\def\@abstractBname{Résumé}
\def\@abstractCname{Zusammenfassung}
\def\abstractAname#1{\gdef\abstractname{#1}}
\def\abstractBname#1{\gdef\@abstractBname{#1}}
\def\abstractCname#1{\gdef\@abstractCname{#1}}

%define advisor length
\newlength{\@advisorlength}

%title page
\newcommand{\maketitlepage}{{
  \newlength{\oldparindent}
  \setlength{\oldparindent}{\parindent}
  \setlength{\parindent}{0pt}
  \setlength{\@advisorlength}{\textwidth-\widthof{\@advisorpref}-1cm}

  \begin{titlepage}
    \thispagestyle{empty}
    \sffamily
    \raisebox{-0.5\height}{\includegraphics[height=2.5cm,width=0.5\textwidth,keepaspectratio]{epfl.pdf}}
    \ifx\@logo\undefined
    \else
    \hfill
    \raisebox{-0.5\height}{\includegraphics[height=2.5cm,width=0.5\textwidth,keepaspectratio]{\@logo}}
    \fi
    \\
    \vspace{0.2\textheight}

    \noindent{{\Huge \@title}}
    \vspace{0.1\textheight}

    {\noindent\Large\textbf{\@author}\\}

    \vspace{0.1\textheight}
    \noindent\large
    \textbf{Master's Thesis} \\ 
    \@school \\
    \@deptpref~\@dept 

    \@advisorpref\hfill
    \parbox[t]{\@advisorlength}{\@advisor}

    \vfill 

    \ifx\@city\@empty\else
    \@city,~
    \fi
    \@submitdate

    \ifx\@extranotes\@empty
    \else
    \\ \@extranotes
    \fi

    \clearpage
    \setlength{\parindent}{\oldparindent}
  \end{titlepage}
}}

\newcommand*{\makeabstract}{
  \ifabstract
  \newpage
  \addcontentsline{toc}{section}{\abstractname}
  \begin{center}
    \Large \textbf{\abstractname}
  \end{center}
  \@abstract
  \clearpage
  \ifx\@abstractB\undefined
  \else
  \newpage
  \addcontentsline{toc}{section}{\@abstractBname}
  \begin{center}
    \Large \textbf{\@abstractBname}
  \end{center}
  \@abstractB
  \clearpage
  \fi
  \ifx\@abstractC\undefined
  \else
  \newpage
  \addcontentsline{toc}{section}{\@abstractCname}
  \begin{center}
    \Large \textbf{\@abstractCname}
  \end{center}
  \@abstractC
  \clearpage
  \fi
  \fi
}

%acknowledgements
\def\makeacknowledgements{
  \ifx\@acknowledgements\undefined
  \else
  \addcontentsline{toc}{section}{Acknowledgements}
  \begin{center}
    \Large \textbf{Acknowledgements}
  \end{center}
  \@acknowledgements
  \clearpage
  \fi
}

%dedication page
\def\makededication{
  \ifx\@dedication\undefined
  \else
  \vspace*{1.5in}
  \begin{flushright}
    \@dedication
  \end{flushright}
  \clearpage
  \fi
}

%various optional lists 
\DeclareOption{noheader}{
  \renewcommand*{\begincmd}{
    \onehalfspacing
    \formatheaders
  }
}
\DeclareOption{onlytitle}{
  \renewcommand*{\begincmd}{
    \maketitlepage
    \onehalfspacing
    \formatheaders
  }
}
\DeclareOption{lot}{\renewcommand*{\makelot}{
  \addcontentsline{toc}{section}{List of Tables}\listoftables}
}
\DeclareOption{lof}{\renewcommand*{\makelof}{
  \addcontentsline{toc}{section}{List of Figures}\listoffigures}
}
\DeclareOption{los}{
  \renewcommand*{\makelos}{
    % \newcommand*\l@symbol{\@dottedtocline{1}{1.5em}{3.5em}}
    \addcontentsline{toc}{section}{List of Symbols}
    \addtocontents{los}{\protect\addvspace{10\p@}}%
    \chapter*{List of Symbols\@mkboth {LIST OF SYMBOLS}{LIST OF SYMBOLS}}
    \@printlos
    \@starttoc{los}
  }
}
\def\addsymbol#1#2{%
  \addtocontents{los}{\protect \contentsline {symbol}{\protect \numberline {#1}{\ignorespaces #2}}{\thepage}{page.\thepage}}
}

% redefine clear double page to not print page number or anything else
\def\cleardoublepage{
  \clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi
}


%inherits report class and associated options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\LoadClass{report}

\long\def\abstract#1{\gdef\@abstract{#1}}
\long\def\abstractB#1{\gdef\@abstractB{#1}}
\long\def\abstractC#1{\gdef\@abstractC{#1}}

% fix problem with xcolor
\RequirePackage{etoolbox}


% automatically generate title etc
\AfterEndPreamble{\begincmd
  %\ifdoubleheaders
    %\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
  %\else
    %\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
  %\fi
}
\renewcommand*{\maketitle}{\maketitlepage}

% Title formatting
\RequirePackage{titlesec}
\RequirePackage{xhfill}

% \titleformat{\chapter}[display]{\sffamily\huge\bfseries}{\strut\xrfill[0.2em]{6pt}[gray]~\thechapter}{1em}{\raggedleft}
\titleformat{\chapter}[display]{\sffamily\huge\bfseries}{\raggedleft\thechapter}{1em}{\raggedleft}

% Command for quickly inserting subfigures
\RequirePackage{subcaption}
\newlength{\figlength}
\newlength{\spacelength}
\newcommand{\twosubfigs}[5]{
  \setlength{\figlength}{#5}
  \setlength{\spacelength}{0.5\textwidth-#5}

  \begin{subfigure}{\figlength}
    \includegraphics[width=\textwidth]{#1}
    \ifx\#2\@empty
    \else
    \caption{#2}
    \fi
  \end{subfigure}
  \hspace{\spacelength}
  \begin{subfigure}{\figlength}
    \includegraphics[width=\textwidth]{#3}
    \ifx\#4\@empty
    \else
    \caption{#4}
    \fi
  \end{subfigure}
}

% command for inserting matlab
\newcommand{\ml}{MATLAB}

\endinput
%% 
%% End of file 'epflthesis.cls'.
