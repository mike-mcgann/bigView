Name:           bigview
Version:        0
Release:        1%{?dist}
Summary:        a

Group:          a
License:        NOSA
URL:            a
Source0:        

BuildRequires:  mesa-libGL-devel 
BuildRequires:  mesa-libGLU-devel
BuildRequires:  mesa-libGLw-devel
BuildRequires:  libXt-devel
BuildRequires:  openmotif-devel
Requires:       

%description


%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc



%changelog
