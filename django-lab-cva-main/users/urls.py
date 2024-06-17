# users/urls.py

from django.urls import path, include
from django.views.generic.base import RedirectView
from users.views import *

urlpatterns = [
    path("", include("django.contrib.auth.urls")),
    path("dashboard/", dashboard, name="dashboard"),
    path("register/", register, name="register"),
    path("error/", error, name="error"),
    path("facelogin/", facelogin, name="facelogin"),
    path("", RedirectView.as_view(url="dashboard/")),
]