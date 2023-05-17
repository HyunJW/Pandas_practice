from django.contrib import admin
from django.urls import path
from shop import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path('', views.home),
    path('join', views.join),
    path('login', views.login),
    path('logout', views.logout),
    path('order', views.order),
    path('query', views.query),
    path('delete_chat', views.delete_chat),
]
