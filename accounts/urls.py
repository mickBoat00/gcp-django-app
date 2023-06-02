from django import urls
from django.urls import include, path, re_path

from accounts import views

urlpatterns = [
    re_path(r'^sign-up/', views.sign_up_user),
    re_path(r'^auth/', include('drf_social_oauth2.urls', namespace='drf'))
]