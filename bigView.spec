Name:           bigView
Version:        0
Release:        1%{?dist}
Summary:        Allows for interactive panning and zooming of images of arbitrary size on desktop PCs running linux.

License:        NOSA
URL:            http://ti.arc.nasa.gov/opensource/projects/bigview
Source0:        bigView.tar.bz2
        
BuildRequires:  libXt-devel
BuildRequires:  openmotif-devel
BuildRequires:  mesa-libGL-devel 
BuildRequires:  mesa-libGLU-devel
BuildRequires:  mesa-libGLw-devel

%description
BigView allows for interactive panning and zooming of images of
arbitrary size on desktop PCs running linux. Additionally, it can work
in a multi-screen environment where multiple PCs cooperate to view a
single large image. Using this software, one can explore -- on
relatively modest machines -- images such as the Mars Orbiter Camera
mosaic [92160x33280 pixels].


%prep
%setup -q -n bigView


%build
./makeLinks.pl
make %{?_smp_mflags}


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/%{_bindir}
cp {browse,browser,genPaged,makeBrowseable.pl,showPaged} \
   %{buildroot}/%{_bindir}


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%{_bindir}/*


%changelog
* Wed Sep 24 2014 Mike McGann <mike.mcgann@nasa.gov> - 0-1
Initial package
